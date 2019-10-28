import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BatmobileComponent } from './batmobile.component';

describe('BatmobileComponent', () => {
  let component: BatmobileComponent;
  let fixture: ComponentFixture<BatmobileComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BatmobileComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BatmobileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
