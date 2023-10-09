from manim import *

class e(Scene):
	def construct(self):
		r=float(input("r = "))
		R=float(input("R = "))
		d=float(input("d = "))
		d/=r
		p=ValueTracker(0)
		C=Circle(radius=R)
		c=always_redraw(lambda:VGroup(Circle(radius=abs(r),color=GREEN),Dot().shift(abs(d*r)*RIGHT),Dot(),Line().set_length(d*r).shift(0.5*d*r*RIGHT)).rotate(p.get_value(),about_point=ORIGIN).move_to(C.get_center()).shift((R+r)*RIGHT).rotate(abs(r/R)*p.get_value(),about_point=C.get_center()))
		t=TracedPath(c[1].get_center)
		self.play(Create(C))
		self.play(Create(c))
		self.add(t)
		self.play(p.animate.set_value(20*PI), run_time=10, rate_func=rate_functions.linear)
		self.wait() 

with tempconfig({"quality": "medium_quality", "preview": True}):
	scene=e()
	scene.render()