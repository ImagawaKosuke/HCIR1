class Triangle { // equilateral triangle
    float x, y, n;
    public Triangle(int x, int y, int n) {
        this.x = x;
        this.y = y;
        this.n = n;
    }
    public void draw(int angle) {
        float b = this.n * sqrt(3) / 4.0;
        float c = this.n / 4.0;
        float d = c * tan(radians(30));

        float x1 = 0;
        float y1 = -(b + d);

        float r = radians(120);
        float x2 = x1*cos(r) - y1*sin(r);
        float y2 = x1*sin(r) + y1*cos(r);

        float x3 = x1*cos(r*2) - y1*sin(r*2);
        float y3 = x1*sin(r*2) + y1*cos(r*2);

        pushMatrix();
        translate(this.x, this.y);
        rotate(radians(angle));
        triangle(x1, y1, x2, y2, x3, y3);
        popMatrix();
    }
}