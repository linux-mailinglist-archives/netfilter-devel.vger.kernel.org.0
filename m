Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82573F3D82
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Aug 2021 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhHVEP3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Aug 2021 00:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhHVEP3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Aug 2021 00:15:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28119C061575
        for <netfilter-devel@vger.kernel.org>; Sat, 21 Aug 2021 21:14:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so16463311pjb.3
        for <netfilter-devel@vger.kernel.org>; Sat, 21 Aug 2021 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HetkxAkGvO5HCifCFUd9NOmVGKRl8rouYSm97DNErK0=;
        b=iQAyon5or+0NWKlTNSZHyTqdAtBsCqd6zENrEQhcAbfXKqTlHEQKpQrjgdUavn2jnj
         DvUgLv3d/flcds6dG13kJ+RGhjupnQ+ZXP72pXIwLXJb11ACx8aBGLpbQjN1lJIvApRS
         kJBvwOziYR6SMo8y3GPIGIvxIsfm9vfJUxvshQ9/Zh23YNqLIK0T06MpUstzG+vY5LQv
         WNWa2hPACQCpFDr5fKBVNZ2oOnqtfbGeRKl6krXNLiNCAOCuAofCgiviAoppKZmrHzxc
         l/LmkwHvf8pz1Zb3qpD7aO42MGRNwOt+vMf4bBe076mwrsWGk3XJ2Rk41rl6EcDq//r0
         WGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HetkxAkGvO5HCifCFUd9NOmVGKRl8rouYSm97DNErK0=;
        b=BjwI6dhwBh3jqCusamQ/mKQBnWUpEEZQ+omUMPGWn2vxuEBeppORsDR2uwm35gx4aY
         HRAsK3uxJaeDKyITAsfCM0za1Be/TZo7AiCfgVgW12ph8lc6+vmi54Te1vfWC7pPEvbf
         nq2dfbSXxrfpp/BxIvr9JLChJknopeKCUpGQgy4zocQmyuCxNv6ACAbNhLuGYdxHOAWK
         6EkX/dz96ZwdWJySpYo6OnRuj++k6LBJTYKbbgqkP2GJPYVHUL3jEph49hwlcpnTz/CV
         9PVzGpyEaagSGLBDIreIr94tUVMnKgHVT2xdtHctVFSQtvHg0aefV2TQjeaKsn5eGhQu
         l//g==
X-Gm-Message-State: AOAM531lu579za92hN8kiJc5On/NnXIVezuB2QRZsYvHNRMmrRcJtmVe
        dnZeylmlKognADex5yik1KXnTw6KuxTyoQ==
X-Google-Smtp-Source: ABdhPJx3Um27zDwU3C5B0KpCUxj9ZhlQ9r+NyFGT2MMk7QqDcSjSJRbDWu3VT3kz94UEdINVOzd6Ww==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr13212349pjq.88.1629605688593;
        Sat, 21 Aug 2021 21:14:48 -0700 (PDT)
Received: from slk1.local.net (n49-192-82-34.sun3.vic.optusnet.com.au. [49.192.82.34])
        by smtp.gmail.com with ESMTPSA id lk17sm5777271pjb.44.2021.08.21.21.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 21:14:48 -0700 (PDT)
Sender: Duncan Roe <duncan.roe2@gmail.com>
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue v4 1/4] build: doc: Fix NAME entry in man pages
Date:   Sun, 22 Aug 2021 14:14:39 +1000
Message-Id: <20210822041442.8394-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a post_process() function to the big shell script inside doxygen/Makefile.am
to make the NAME line in a man page list the functions defined, like other man
pages do.
This function does a number of other things:
- If there is a "Modules" section, delete it
- If "Detailed Description" is empty, delete "Detailed Description" line
- Reposition SYNOPSIS (with headers that we inserted) to start of page,
  integrating with defined functions to look like other man pages
- Delete all "Definition at line nnn" lines
- Delete lines that make older versions of man o/p an unwanted blank line
- Insert spacers and comments so Makefile.am is more readable
- Delete lines that make older versions of man o/p an unwanted blank line

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
v2: Delete lines that make older versions of man o/p an unwanted blank line
v3: same as v2 but there are now 2 more patches
v4: Split off the shell script again but make distcheck passes this time
 doxygen/Makefile.am | 172 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/doxygen/Makefile.am b/doxygen/Makefile.am
index 29078de..5bcef61 100644
--- a/doxygen/Makefile.am
+++ b/doxygen/Makefile.am
@@ -21,19 +21,32 @@ doxyfile.stamp: $(doc_srcs) Makefile.am
 # The command has to be a single line so the functions work
 # and so `make` gives all lines to `bash -c`
 # (hence ";\" at the end of every line but the last).
+# automake (run by autogen.sh) allows comments starting ## after continuations
+# but not blank lines
+
 	/bin/bash -p -c 'declare -A renamed_page;\
+##
 main(){ set -e; cd man/man3; rm -f _*;\
   count_real_pages;\
   rename_real_pages;\
   make_symlinks;\
+  post_process;\
 };\
+##
 count_real_pages(){ page_count=0;\
+  ##
+  ## Count "real" man pages (i.e. not generated by MAN_LINKS)
+  ## MAN_LINKS pages are 1-liners starting .so
+  ## Method: list files in descending order of size,
+  ## looking for the first 1-liner
+  ##
   for i in $$(ls -S);\
   do head -n1 $$i | grep -E -q '^\.so' && break;\
     page_count=$$(($$page_count + 1));\
   done;\
   first_link=$$(($$page_count + 1));\
 };\
+##
 rename_real_pages(){ for i in $$(ls -S | head -n$$page_count);\
   do for j in $$(ls -S | tail -n+$$first_link);\
     do grep -E -q $$i$$ $$j && break;\
@@ -42,10 +55,169 @@ rename_real_pages(){ for i in $$(ls -S | head -n$$page_count);\
     renamed_page[$$i]=$$j;\
   done;\
 };\
+##
 make_symlinks(){ for j in $$(ls -S | tail -n+$$first_link);\
   do ln -sf $${renamed_page[$$(cat $$j | cut -f2 -d/)]} $$j;\
   done;\
 };\
+##
+post_process(){ make_temp_files;\
+  ##
+  ## DIAGNOSTIC / DEVELOPMENT CODE
+  ## set -x and restrict processing to keep_me: un-comment to activate
+  ## Change keep_me as required
+  ##
+  ##keep_me=nfq_icmp_get_hdr.3;\
+  ##do_diagnostics;\
+  ##
+  ## Work through the "real" man pages
+  for target in $$(ls -S | head -n$$page_count);\
+  do mygrep "^\\.SH \"Function Documentation" $$target;\
+    ## Next file if this isn't a function page
+    [ $$linnum -ne 0 ] || continue;\
+    ##
+    del_modules;\
+    del_bogus_synopsis;\
+    fix_name_line;\
+    move_synopsis;\
+    del_empty_det_desc;\
+    del_def_at_lines;\
+    fix_double_blanks;\
+  done;\
+  ##
+  remove_temp_files;\
+};\
+##
+fix_double_blanks(){ linnum=1;\
+  ##
+  ## Older versions of man display a blank line on encountering "\fB\fP";
+  ## newer versions of man do not.
+  ## doxygen emits "\fB\fP" on seeing "\par" on a line by itself.
+  ## "\par" gives us double-spacing in the web doc, which we want, but double-
+  ## spacing looks odd in a man page so remove "\fB\fP".
+  ##
+  while [ $$linnum -ne 0 ];\
+  do mygrep \\\\fB\\\\fP $$target;\
+    [ $$linnum -eq 0 ] || delete_lines $$linnum $$linnum;\
+  done;\
+};\
+##
+del_def_at_lines(){ linnum=1;\
+  while [ $$linnum -ne 0 ];\
+  do mygrep "^Definition at line [[:digit:]]* of file" $$target;\
+    [ $$linnum -eq 0 ] || delete_lines $$(($$linnum - 1)) $$linnum;\
+  done;\
+};\
+##
+## Only invoked if you un-comment the 2 diagnostic / development lines above
+do_diagnostics(){ mv $$keep_me xxx;\
+  rm *.3;\
+  mv xxx $$keep_me;\
+  page_count=1;\
+  set -x;\
+};\
+##
+del_empty_det_desc(){ mygrep "^\\.SH \"Function Documentation" $$target;\
+  i=$$linnum;\
+  mygrep "^\\.SH \"Detailed Description" $$target;\
+  [ $$linnum -ne 0  ] || return 0;\
+  [ $$(($$i - $$linnum)) -eq 3 ] || return 0;\
+  delete_lines $$linnum $$(($$i -1));\
+};\
+##
+move_synopsis(){ mygrep "SH SYNOPSIS" $$target;\
+  [ $$linnum -ne 0  ] || return 0;\
+  i=$$linnum;\
+  ## If this is a doxygen-created synopsis, leave it.
+  ## (We haven't inserted our own one in the source yet)
+  mygrep "^\\.SS \"Functions" $$target;\
+  [ $$i -gt $$linnum ] || return 0;\
+  ##
+  mygrep "^\\.SH \"Function Documentation" $$target;\
+  j=$$(($$linnum - 1));\
+  head -n$$(($$j - 1)) $$target | tail -n$$(($$linnum - $$i - 1)) >$$fileC;\
+  delete_lines $$i $$j;\
+  mygrep "^\\.SS \"Functions" $$target;\
+  head -n$$(($$linnum - 1)) $$target >$$fileA;\
+  tail -n+$$(($$linnum + 1)) $$target >$$fileB;\
+  cat $$fileA $$fileC $$fileB >$$target;\
+};\
+##
+fix_name_line(){ all_funcs="";\
+  ##
+  ## Search a shortened version of the page in case there are .RI lines later
+  mygrep "^\\.SH \"Function Documentation" $$target;\
+  head -n$$linnum $$target >$$fileC;\
+  ##
+  while :;\
+  do mygrep ^\\.RI $$fileC;\
+    [ $$linnum -ne 0 ] || break;\
+    ## Discard this entry
+    tail -n+$$(($$linnum + 1)) $$fileC >$$fileB;\
+    cp $$fileB $$fileC;\
+    ##
+    func=$$(cat $$fileG | cut -f2 -d\\ | cut -c3-);\
+    [ -z "$$all_funcs" ] && all_funcs=$$func ||\
+      all_funcs="$$all_funcs, $$func";\
+  done;\
+  ## For now, assume name is at line 5
+  head -n4 $$target >$$fileA;\
+  desc=$$(head -n5 $$target | tail -n1 | cut -f3- -d" ");\
+  tail -n+6 $$target >$$fileB;\
+  cat $$fileA >$$target;\
+  echo "$$all_funcs \\- $$desc" >>$$target;\
+  cat $$fileB >>$$target;\
+};\
+##
+del_modules(){ mygrep "^\.SS \"Modules" $$target;\
+  [ $$linnum -ne 0  ] || return 0;\
+  i=$$linnum;\
+  mygrep "^\\.SS \"Functions" $$target;\
+  delete_lines $$i $$(($$linnum - 1));\
+};\
+##
+del_bogus_synopsis(){ mygrep "SH SYNOPSIS" $$target;\
+  ##
+  ## doxygen 1.8.20 inserts its own SYNOPSIS line but there is no mention
+  ## in the documentation or git log what to do with it.
+  ## So get rid of it
+  ##
+  [ $$linnum -ne 0  ] || return 0;\
+  i=$$linnum;\
+  ## Look for the next one
+  tail -n+$$(($$i + 1)) $$target >$$fileC;\
+  mygrep "SH SYNOPSIS" $$fileC;\
+  [ $$linnum -ne 0  ] || return 0;\
+  ##
+  mygrep "^\\.SS \"Functions" $$target;\
+  delete_lines $$i $$(($$linnum - 1));\
+};\
+##
+## Delete lines $1 through $2 from $target
+delete_lines(){ head -n$$(($$1 - 1)) $$target >$$fileA;\
+  tail -n+$$(($$2 +1)) $$target >$$fileB;\
+  cat $$fileA $$fileB >$$target;\
+};\
+##
+mygrep(){ set +e;\
+  grep -En "$$1" $$2 2>/dev/null >$$fileH;\
+  [ $$? -ne 0 ] && linnum=0 ||\
+    { head -n1 $$fileH >$$fileG; linnum=$$(cat $$fileG | cut -f1 -d:); };\
+  set -e;\
+};\
+##
+make_temp_files(){ temps="A B C G H";\
+  for i in $$temps;\
+  do declare -g file$$i=$$(mktemp);\
+  done;\
+};\
+##
+remove_temp_files(){ for i in $$temps;\
+  do j=file$$i;\
+    rm $${!j};\
+  done;\
+};\
+##
 main'
 
 	touch doxyfile.stamp
-- 
2.17.5

