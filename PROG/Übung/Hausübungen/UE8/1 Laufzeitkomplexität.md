---
tldraw-file: true
tags:
  - tldraw
---


```json !!!_START_OF_TLDRAW_DATA__DO_NOT_CHANGE_THIS_PHRASE_!!!
{
	"meta": {
		"uuid": "5ac674b5-a38d-4f50-85aa-30afe00fb4f0",
		"plugin-version": "1.26.2",
		"tldraw-version": "3.15.3"
	},
	"raw": {
		"tldrawFileFormatVersion": 1,
		"schema": {
			"schemaVersion": 2,
			"sequences": {
				"com.tldraw.store": 4,
				"com.tldraw.asset": 1,
				"com.tldraw.camera": 1,
				"com.tldraw.document": 2,
				"com.tldraw.instance": 25,
				"com.tldraw.instance_page_state": 5,
				"com.tldraw.page": 1,
				"com.tldraw.instance_presence": 6,
				"com.tldraw.pointer": 1,
				"com.tldraw.shape": 4,
				"com.tldraw.asset.bookmark": 2,
				"com.tldraw.asset.image": 5,
				"com.tldraw.asset.video": 5,
				"com.tldraw.shape.arrow": 7,
				"com.tldraw.shape.bookmark": 2,
				"com.tldraw.shape.draw": 2,
				"com.tldraw.shape.embed": 4,
				"com.tldraw.shape.frame": 1,
				"com.tldraw.shape.geo": 10,
				"com.tldraw.shape.group": 0,
				"com.tldraw.shape.highlight": 1,
				"com.tldraw.shape.image": 5,
				"com.tldraw.shape.line": 5,
				"com.tldraw.shape.note": 9,
				"com.tldraw.shape.text": 3,
				"com.tldraw.shape.video": 4,
				"com.tldraw.binding.arrow": 1
			}
		},
		"records": [
			{
				"x": 0,
				"y": 0,
				"lastActivityTimestamp": 0,
				"meta": {},
				"id": "pointer:pointer",
				"typeName": "pointer"
			},
			{
				"x": 1290,
				"y": 600,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:eAchXGiZz9Z5mqGDxFgKj",
				"type": "draw",
				"props": {
					"segments": [
						{
							"type": "free",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 0.5
								}
							]
						},
						{
							"type": "straight",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 1
								},
								{
									"x": 0,
									"y": -446.36,
									"z": 1
								}
							]
						}
					],
					"color": "black",
					"fill": "none",
					"dash": "draw",
					"size": "m",
					"isComplete": true,
					"isClosed": false,
					"isPen": false,
					"scale": 1
				},
				"parentId": "page:page",
				"index": "a52Sf",
				"typeName": "shape"
			},
			{
				"x": 0,
				"y": 0,
				"z": 1,
				"meta": {},
				"id": "camera:page:page",
				"typeName": "camera"
			},
			{
				"x": 330.6831793626838,
				"y": 241.16647029008507,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:w4LtQHllvyBj5QW2y-zw2",
				"type": "text",
				"props": {
					"color": "black",
					"size": "m",
					"w": 649.0078125,
					"font": "mono",
					"textAlign": "start",
					"autoSize": true,
					"scale": 1,
					"richText": {
						"type": "doc",
						"content": [
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "FUNCTION SumSquares1(a, b: LONGINT): LONGINT;"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "  VAR"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "    sum, i: LONGINT;"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "BEGIN"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "  sum := 0;"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "  FOR i := a TO b DO BEGIN"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "    sum := sum + i * i;"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "  END;"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "  SumSquares1 := sum"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "END;"
									}
								]
							}
						]
					}
				},
				"parentId": "page:page",
				"index": "a1",
				"typeName": "shape"
			},
			{
				"editingShapeId": null,
				"croppingShapeId": null,
				"selectedShapeIds": [],
				"hoveredShapeId": null,
				"erasingShapeIds": [],
				"hintingShapeIds": [],
				"focusedGroupId": null,
				"meta": {},
				"id": "instance_page_state:page:page",
				"pageId": "page:page",
				"typeName": "instance_page_state"
			},
			{
				"x": 306.3827418437583,
				"y": 214.29840558655735,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:tf1G42jOUXdZOhT0AEE64",
				"type": "draw",
				"props": {
					"segments": [
						{
							"type": "straight",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 0.5
								},
								{
									"x": 1212.48,
									"y": 0,
									"z": 1
								}
							]
						}
					],
					"color": "black",
					"fill": "none",
					"dash": "draw",
					"size": "m",
					"isComplete": true,
					"isClosed": false,
					"isPen": false,
					"scale": 1
				},
				"parentId": "page:page",
				"index": "a239S",
				"typeName": "shape"
			},
			{
				"x": 1160.4872664281736,
				"y": 597.0499100268423,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:gGAV5Ozl6bjjwxIKdOc9y",
				"type": "draw",
				"props": {
					"segments": [
						{
							"type": "free",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -1.02,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -2.03,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -3.05,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -4.06,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -5.08,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -6.09,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -7.11,
									"z": 0.5
								}
							]
						},
						{
							"type": "straight",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 1
								},
								{
									"x": 0,
									"y": -448.28,
									"z": 1
								}
							]
						}
					],
					"color": "black",
					"fill": "none",
					"dash": "draw",
					"size": "m",
					"isComplete": true,
					"isClosed": false,
					"isPen": false,
					"scale": 1
				},
				"parentId": "page:page",
				"index": "a483X",
				"typeName": "shape"
			},
			{
				"x": 1015.3056612956517,
				"y": 598.06516600679,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:WpcG2aUpnnPlpMtWqMjdc",
				"type": "draw",
				"props": {
					"segments": [
						{
							"type": "free",
							"points": [
								{
									"x": 0,
									"y": 0,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -1.02,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -1.02,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -2.03,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -3.05,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -6.09,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -7.11,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -10.15,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -11.17,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -12.18,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -13.2,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -14.21,
									"z": 0.5
								}
							]
						},
						{
							"type": "straight",
							"points": [
								{
									"x": 0,
									"y": -14.21,
									"z": 0.5
								},
								{
									"x": 0,
									"y": -447.42,
									"z": 1
								}
							]
						}
					],
					"color": "black",
					"fill": "none",
					"dash": "draw",
					"size": "m",
					"isComplete": true,
					"isClosed": false,
					"isPen": false,
					"scale": 1
				},
				"parentId": "page:page",
				"index": "a31sz",
				"typeName": "shape"
			},
			{
				"meta": {},
				"id": "page:page",
				"name": "Page 1",
				"index": "a1",
				"typeName": "page"
			},
			{
				"gridSize": 10,
				"name": "",
				"meta": {},
				"id": "document:document",
				"typeName": "document"
			},
			{
				"followingUserId": null,
				"opacityForNextShape": 1,
				"stylesForNextShape": {},
				"brush": null,
				"scribbles": [],
				"cursor": {
					"type": "default",
					"rotation": 0
				},
				"isFocusMode": false,
				"exportBackground": true,
				"isDebugMode": false,
				"isToolLocked": false,
				"screenBounds": {
					"x": 0,
					"y": 0,
					"w": 1080,
					"h": 720
				},
				"insets": [
					false,
					false,
					false,
					false
				],
				"zoomBrush": null,
				"isGridMode": false,
				"isPenMode": false,
				"chatMessage": "",
				"isChatting": false,
				"highlightedUserIds": [],
				"isFocused": false,
				"devicePixelRatio": 2,
				"isCoarsePointer": false,
				"isHoveringCanvas": null,
				"openMenus": [],
				"isChangingStyle": false,
				"isReadonly": false,
				"meta": {},
				"duplicateProps": null,
				"id": "instance:instance",
				"currentPageId": "page:page",
				"typeName": "instance"
			}
		]
	}
}
!!!_END_OF_TLDRAW_DATA__DO_NOT_CHANGE_THIS_PHRASE_!!!
```