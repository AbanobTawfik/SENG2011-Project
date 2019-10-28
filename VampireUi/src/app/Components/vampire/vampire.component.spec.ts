import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VampireComponent } from './vampire.component';

describe('VampireComponent', () => {
  let component: VampireComponent;
  let fixture: ComponentFixture<VampireComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VampireComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VampireComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
