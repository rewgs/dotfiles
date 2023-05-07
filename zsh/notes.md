load order: .zshenv<sup>1</sup> -> .zprofile<sup>2</sup> -> .zshrc<sup>3</sup> -> .zlogin<sup>4</sup> -> .zlogout<sup>5</sup>
1. Always loaded
2. Loaded if login shell
3. Loaded if interactive shell
4. Loaded if login shell
5. Loaded...sometimes

load order: 
- .zshenv                         → 
- .zprofile   (if login)          → 
- .zshrc      (if interactive)    → 
- .zlogin     (if login)          → 
- .zlogout    (sometimes)
