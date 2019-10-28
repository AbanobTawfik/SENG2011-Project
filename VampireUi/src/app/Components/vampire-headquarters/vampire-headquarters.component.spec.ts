import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VampireHeadquartersComponent } from './vampire-headquarters.component';

describe('VampireHeadquartersComponent', () => {
  let component: VampireHeadquartersComponent;
  let fixture: ComponentFixture<VampireHeadquartersComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VampireHeadquartersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VampireHeadquartersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
