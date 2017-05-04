import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private int numBombs =  10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private LevelButtons level1;
private boolean lost = false;
void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);

    // make the manager
    Interactive.make( this );

    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r, c);
        }
    }
    level1 = new LevelButtons(100, 20, 10, 10, "Level 1");

    setBombs();
}
public void setBombs()
{
    //your code
    bombs = new ArrayList <MSButton>();
    for(int i=0; i< numBombs; i++){
         int rows = (int)(Math.random() * NUM_ROWS);
         int collumn = (int)(Math.random() * NUM_COLS);
        if(!bombs.contains(buttons[rows][collumn]))
        bombs.add(buttons[rows][collumn]);
    }
}
public boolean isPlaying(){
  if(lost){
    return false;
  }
  if(isWon()){
    return false;
  }
  return true;
}
public void draw ()
{

  background( 0 );
    if(isWon())
        displayWinningMessage();
      if(lost)
        displayLosingMessage();
}
public boolean isWon()
{
    //your code here
    int count  = 0;
    for(int r = 0; r < buttons.length; r++){
      for(int c = 0; c < buttons[r].length; c++){
        if(!bombs.contains(buttons[r][c]) && buttons[r][c].isClicked()){
          count++;
        }
      }
    }
    if(count == (400 - bombs.size())) return true;
    return false;
}
public void displayLosingMessage()
{
    //your code here
    fill(255);
    text("you lose", 200, 10);
}
public void displayWinningMessage()
{
    //your code here
    fill(255);
    text("you win", 200, 10);
}
public class LevelButtons{
  private float x, y, width, height;
  private String label;
  private boolean clicked, marked;
  public LevelButtons(int xx, int yy, int h, int w, String l){
    width = w;
    height = h;
    x = xx;
    y = yy;
    label = l;
    marked = clicked = false;
    Interactive.add(this);
  }
  public boolean isClicked(){
    return clicked;
  }
  public void draw(){
    if (clicked)
    fill(50);
    else
    fill( 255 );
    rect(x, y, width, height);
    fill(0);
  }
  public void mousePressed(){
    clicked = !clicked;
  }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc;
        x = c*width;
        y = r*height + 100;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager

    public void mousePressed ()
    {

        //your code here
    if(isPlaying()){
      clicked = true;
        if(keyPressed == true){
          marked = !marked;
          if(marked == false)
          clicked = false;
        }
        else if(bombs.contains(this))
          lost = true;
        else if(countBombs(r, c) > 0)
          label = "" + countBombs(r, c);
        else{
          if(isValid(r+1, c) && !buttons[r+1][c].isClicked())
          buttons[r+1][c].mousePressed();

          if(isValid(r-1, c) && !buttons[r-1][c].isClicked())
          buttons[r-1][c].mousePressed();

          if(isValid(r, c+1) && !buttons[r][c+1].isClicked())
          buttons[r][c+1].mousePressed();

          if(isValid(r, c-1) && !buttons[r][c-1].isClicked())
          buttons[r][c-1].mousePressed();

          if(isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
          buttons[r+1][c-1].mousePressed();

          if(isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
          buttons[r-1][c-1].mousePressed();

          if(isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
          buttons[r+1][c+1].mousePressed();

          if(isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
          buttons[r-1][c+1].mousePressed();
        }
    }

    }

    public void draw ()
    {
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) )
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
        return true;

        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r+1, c) && bombs.contains(buttons[r+1][c])) numBombs++;
        if(isValid(r-1, c) && bombs.contains(buttons[r-1][c])) numBombs++;
        if(isValid(r, c-1) && bombs.contains(buttons[r][c-1])) numBombs++;
        if(isValid(r, c+1) && bombs.contains(buttons[r][c+1])) numBombs++;
        if(isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1])) numBombs++;
        if(isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1])) numBombs++;
        if(isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1])) numBombs++;
        if(isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1])) numBombs++;
        return numBombs;
    }
}
