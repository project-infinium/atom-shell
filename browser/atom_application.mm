// Copyright (c) 2013 GitHub, Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "browser/atom_application.h"

#include "base/auto_reset.h"
#include "base/logging.h"
#include "browser/native_window.h"

@implementation AtomApplication

- (BOOL)isHandlingSendEvent {
  return handlingSendEvent_;
}

- (void)sendEvent:(NSEvent*)event {
  base::AutoReset<BOOL> scoper(&handlingSendEvent_, YES);
  [super sendEvent:event];
}

- (void)setHandlingSendEvent:(BOOL)handlingSendEvent {
  handlingSendEvent_ = handlingSendEvent;
}

+ (AtomApplication*)sharedApplication {
  return (AtomApplication*)[super sharedApplication];
}

- (IBAction)closeAllWindows:(id)sender {
  std::vector<atom::NativeWindow*> windows = atom::NativeWindow::windows();
  for (size_t i = 0; i < windows.size(); ++i)
    windows[i]->Close();
}

@end