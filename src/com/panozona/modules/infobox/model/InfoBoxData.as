/*
Copyright 2011 Marek Standio.

This file is part of SaladoPlayer.

SaladoPlayer is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published
by the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

SaladoPlayer is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with SaladoPlayer. If not, see <http://www.gnu.org/licenses/>.
*/
package com.panozona.modules.infobox.model {
	
	import com.panozona.modules.infobox.model.structure.Close;
	import com.panozona.player.module.data.DataNode;
	import com.panozona.player.module.data.ModuleData;
	import com.panozona.player.module.utils.DataNodeTranslator;
	
	public class InfoBoxData {
		
		public const windowData:WindowData = new WindowData();
		public const close:Close = new Close();
		public const viewerData:ViewerData = new ViewerData();
		public const articleData:ArticleData = new ArticleData();
		
		public function InfoBoxData(moduleData:ModuleData, saladoPlayer:Object) {
			var tarnslator:DataNodeTranslator = new DataNodeTranslator(saladoPlayer.managerData.debugMode);
			for each(var dataNode:DataNode in moduleData.nodes) {
				if (dataNode.name == "window") {
					tarnslator.dataNodeToObject(dataNode, windowData.window);
				}else if (dataNode.name == "close") {
					tarnslator.dataNodeToObject(dataNode, close);
				}else if (dataNode.name == "viewer") {
					tarnslator.dataNodeToObject(dataNode, viewerData.viewer);
				}else if (dataNode.name == "articles") {
					tarnslator.dataNodeToObject(dataNode, articleData.articles);
				}else {
					throw new Error("Invalid node name: " + dataNode.name);
				}
			}
			
			windowData.open = windowData.window.open;
			
			if (saladoPlayer.managerData.debugMode) {
				if (viewerData.viewer.moveEnabled || viewerData.viewer.zoomEnabled || viewerData.viewer.dragEnabled) {
					if (viewerData.viewer.path == null || !viewerData.viewer.path.match(/^(.+)\.(png|gif|jpg|jpeg|swf)$/i))
						throw new Error("Invalid viewer path: " + viewerData.viewer.path);
				}
				if (windowData.window.onOpen != null && saladoPlayer.managerData.getActionDataById(windowData.window.onOpen) == null) {
					throw new Error("Action does not exist: " + windowData.window.onOpen);
				}
				if (windowData.window.onClose != null && saladoPlayer.managerData.getActionDataById(windowData.window.onClose) == null) {
					throw new Error("Action does not exist: " + windowData.window.onClose);
				}
				if (articleData.articles.getChildrenOfGivenClass(Article).length == 0) {
					throw new Error("No articles found.");
				}
				var articleIds:Object = new Object();
				
				for each(var artilce:Article in articleData.articles.getChildrenOfGivenClass(Articlr)) {
					if (article.id == null) throw new Error("Article id not specified.");
					if (article.onSet != null && saladoPlayer.managerData.getActionDataById(article.onSet) == null) throw new Error("Action does not exist: " + article.onSet);
					if (articleIds[article.id] != undefined) {
						throw new Error("Repeating article id: " + article.id);
					}else {
						articleIds[article.id] = ""; // something
					}
				}
			}
		}
	}
}