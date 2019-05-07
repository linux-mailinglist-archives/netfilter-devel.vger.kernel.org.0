Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5704416476
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 May 2019 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEGNVn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 May 2019 09:21:43 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:58372 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEGNVn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 May 2019 09:21:43 -0400
Received: from localhost ([::1]:43230 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hO02Q-0007px-A1; Tue, 07 May 2019 15:21:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] py: Fix gitignore of lib/ directory
Date:   Tue,  7 May 2019 15:21:45 +0200
Message-Id: <20190507132145.3215-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pattern is not a PCRE one but merely a shell glob. Hence 'lib.*' matches
only 'lib.' prefix, not also 'lib'.

Fixes: bf9653667a39e ("python: installation of binding via make install")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 py/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/py/.gitignore b/py/.gitignore
index 09c1e62bbd128..10c1710732cbf 100644
--- a/py/.gitignore
+++ b/py/.gitignore
@@ -1,5 +1,5 @@
 *.pyc
 build/
 dist/
-lib.*/
+lib*/
 nftables.egg-info/
-- 
2.21.0

