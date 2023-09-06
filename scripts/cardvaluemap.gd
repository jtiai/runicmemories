extends Node


const CARD_VALUE_MAP = {
	1: "ᚠ",
	2: "ᚡ",
	3: "ᚢ",
	4: "ᚣ",
	5: "ᚤ",
	6: "ᚥ",
	7: "ᚦ",
	8: "ᚧ",
	9: "ᚨ",
	10: "ᚩ",
	11: "ᚪ",
	12: "ᚫ",
	13: "ᚬ",
	14: "ᚭ",
	15: "ᚮ",
	16: "ᚯ",
	17: "ᚰ",
	18: "ᚱ",
	19: "ᚲ",
	20: "ᚳ",
	21: "ᚴ",
	22: "ᚵ",
	23: "ᚶ",
	24: "ᚷ",
	25: "ᚸ",
	26: "ᚹ",
	27: "ᚺ",
	28: "ᚻ",
	29: "ᚼ",
	30: "ᚽ",
	31: "ᚾ",
	32: "ᚿ",
	33: "ᛀ",
	34: "ᛁ",
	35: "ᛂ",
	36: "ᛃ",
	37: "ᛄ",
	38: "ᛅ",
	39: "ᛆ",
	40: "ᛇ",
	41: "ᛈ",
	42: "ᛉ",
	43: "ᛊ",
	44: "ᛋ",
	45: "ᛌ",
	46: "ᛍ",
	47: "ᛎ",
	48: "ᛏ",
	49: "ᛐ",
	50: "ᛑ",
	51: "ᛒ",
	52: "ᛓ",
	53: "ᛔ",
	54: "ᛕ",
	55: "ᛖ",
	56: "ᛗ",
	57: "ᛘ",
	58: "ᛘ",
	59: "ᛚ",
	60: "ᛛ",
	61: "ᛜ",
	62: "ᛝ",
	63: "ᛞ",
	64: "ᛟ",
	65: "ᛠ",
	66: "ᛡ",
	67: "ᛢ",
	68: "ᛣ",
	69: "ᛤ",
	70: "ᛥ",
	71: "ᛦ",
	72: "ᛧ",
	73: "ᛨ",
	74: "ᛩ",
	75: "ᛪ",
	76: "᛫",
	77: "᛬",
	78: "᛭",
	79: "ᛮ",
	80: "ᛯ",
	81: "ᛰ",
	82: "ᛱ",
	83: "ᛲ",
	84: "ᛳ",
	85: "ᛴ",
	86: "ᛵ",
	87: "ᛶ",
	88: "ᛷ",
	89: "ᛷ",
}

const NUM_CARD_VALUES = 89
