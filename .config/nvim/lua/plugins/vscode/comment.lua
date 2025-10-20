return {
	"terrortylor/nvim-comment",
	enabled = false,
	event = "InsertEnter",
	-- had to define the main module coz lazynvim throw couldn't find the module 'nvim-comment'
	-- to pass the opts to (obiviously), coz the name of the module is 'nvim_comment'
	main = "nvim_comment",
	opts = {
		comment_empty = false,
	},
}
