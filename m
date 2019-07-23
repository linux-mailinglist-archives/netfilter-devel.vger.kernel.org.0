Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1594A7191A
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfGWNXY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 09:23:24 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48422 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGWNXX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:23:23 -0400
Received: from localhost ([::1]:33280 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hpulG-0007vL-Be; Tue, 23 Jul 2019 15:23:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH v2 0/2] parser_bison: Get rid of (most) bison compiler warnings
Date:   Tue, 23 Jul 2019 15:23:11 +0200
Message-Id: <20190723132313.13238-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eliminate as many bison warnings emitted since bison-3.3 as possible.
Sadly getting bison, flex and automake right is full of pitfalls so on
one hand this series does not fix for deprecated %name-prefix statement
and on the other passes -Wno-yacc to bison to not complain about POSIX
incompatibilities although automake causes to run bison in POSIX compat
mode in the first place. Fixing either of those turned out to be
non-trivial.

Changes since v1:
- Drop nfnl_osf patch, Fernando took care of that already.
- Split remaining patch in two.
- Document which warnings are being silenced.

Phil Sutter (2):
  parser_bison: Fix for deprecated statements
  src: Call bison with -Wno-yacc to silence warnings

 src/Makefile.am    | 2 +-
 src/parser_bison.y | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.22.0

