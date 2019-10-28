import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PathologyComponent } from './pathology.component';

describe('PathologyComponent', () => {
  let component: PathologyComponent;
  let fixture: ComponentFixture<PathologyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PathologyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PathologyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
