Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969DD115003
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 12:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFLri (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 06:47:38 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34906 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfLFLri (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:47:38 -0500
Received: from localhost ([::1]:47996 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1idC5A-0002lN-Fe; Fri, 06 Dec 2019 12:47:36 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/6] A series of covscan-indicated fixes
Date:   Fri,  6 Dec 2019 12:47:05 +0100
Message-Id: <20191206114711.6015-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I had to dig through a huge coverity tool report, these are the things I
found worth fixing.

Phil Sutter (6):
  xtables-restore: Avoid access of uninitialized data
  extensions: time: Avoid undefined shift
  extensions: cluster: Avoid undefined shift
  libxtables: Avoid buffer overrun in xtables_compatible_revision()
  xtables-translate: Guard strcpy() call in xlate_ifname()
  extensions: among: Check call to fstat()

 extensions/libebt_among.c    | 6 +++++-
 extensions/libxt_cluster.c   | 2 +-
 extensions/libxt_time.c      | 2 +-
 iptables/xtables-restore.c   | 2 +-
 iptables/xtables-translate.c | 5 ++---
 libxtables/xtables.c         | 3 ++-
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.24.0

