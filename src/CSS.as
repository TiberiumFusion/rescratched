/*
 * Scratch Project Editor and Player
 * Copyright (C) 2014 Massachusetts Institute of Technology
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

// CSS.as
// Paula Bonta, November 2011
//
// Styles for Scratch Editor based on the Upstatement design.

package {
	import flash.text.*;
	import assets.Resources;

public class CSS {

	public static function topBarColor():int { return Scratch.app.isExtensionDevMode ? topBarColor_ScratchX : topBarColor_default; }
	public static function backgroundColor():int { return Scratch.app.isExtensionDevMode ? backgroundColor_ScratchX : backgroundColor_default; }

	// ScratchX
	public static const topBarColor_ScratchX:int = 0x30485f;
	public static const backgroundColor_ScratchX:int = 0x3f5975;

	// Colors
	public static const white:int = 0xFFFFFF;
	public static const backgroundColor_default:int = white;
	public static const topBarColor_default:int = 0x9C9EA2;
	public static const tabColor:int = 0xE6E8E8;
	public static const panelLighterColor:int = 0xFBFBFB;
	public static const panelColor:int = 0xF2F2F2;
	public static const panelDarkerColor:int = 0xDDDEDE;
	public static const itemSelectedColor:int = 0xD0D0D0;
	public static const borderColor:int = 0xD0D1D2;
	public static const borderDarker1Color:int = 0xBCBDBE;
	public static const borderDarker2Color:int = 0x7C7E81;
	public static const textColor:int = 0x5C5D5F; // 0x6C6D6F
	public static const textLighterColor:int = 0xB0B1B3;
	public static const buttonLabelColor:int = textColor;
	public static const buttonLabelOverColor:int = 0xFBA939;
	public static const offColor:int = 0x8F9193; // 0x9FA1A3
	public static const onColor:int = textColor; // 0x4C4D4F
	public static const overColor:int = 0x179FD7;
	public static const arrowColor:int = 0xA6A8AC;
	public static const consoleTextColor:int = 0x454647;
	public static const consoleTextDarkerColor:int = 0x272829;
	public static const iupsReadoutLineColor:int = 0xCDCECF;
	
	// scratch-flash fonts
	public static const font:String = Resources.chooseFont(['Arial', 'Verdana', 'DejaVu Sans']);
	public static const menuFontSize:int = 12;
	public static const normalTextFormat:TextFormat = new TextFormat(font, 12, textColor);
	public static const topBarButtonFormat:TextFormat = new TextFormat(font, 12, white, true);
	public static const titleFormat:TextFormat = new TextFormat(font, 14, textColor);
	public static const thumbnailFormat:TextFormat = new TextFormat(font, 11, textColor);
	public static const thumbnailExtraInfoFormat:TextFormat = new TextFormat(font, 9, textColor);
	public static const projectTitleFormat:TextFormat = new TextFormat(font, 13, textColor);
	public static const projectInfoFormat:TextFormat = new TextFormat(font, 12, textColor);
	// Rescratched fonts
	public static const consoleTextRegularFormat:TextFormat = new TextFormat("InconsolataRegular", 12, consoleTextColor);
	public static const consoleTextBoldFormat:TextFormat = new TextFormat("InconsolataBold", 12, consoleTextColor);
	public static const consoleTextDarkerRegularFormat:TextFormat = new TextFormat("InconsolataRegular", 12, consoleTextDarkerColor);
	public static const consoleTextDarkerBoldFormat:TextFormat = new TextFormat("InconsolataBold", 12, consoleTextDarkerColor);
	public static const consoleTextBlackRegularFormat:TextFormat = new TextFormat("InconsolataRegular", 12, 0x000000);

	// Section title bars
	public static const titleBarColors:Array = [white, tabColor];
	public static const titleBarH:int = 30;
}}
