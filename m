Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3D10513C
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 12:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKULQM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 06:16:12 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:40942 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKULQM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:16:12 -0500
Received: from localhost ([::1]:54032 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iXkRX-0001DQ-OZ; Thu, 21 Nov 2019 12:16:11 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [arptables PATCH 0/3] Some minor fixes
Date:   Thu, 21 Nov 2019 12:15:56 +0100
Message-Id: <20191121111559.27066-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These are some patches I found while cleaning up the attic. They add a
gitignore file, fix for a compiler warning and simplify code in libarptc
a bit.

Phil Sutter (3):
  Add .gitignore
  Eliminate compiler warning about size passed to strncmp()
  libarptc: Simplify alloc_handle by using calloc()

 .gitignore               |  4 ++++
 arptables.c              |  3 +--
 libarptc/libarptc_incl.c | 11 +++--------
 3 files changed, 8 insertions(+), 10 deletions(-)
 create mode 100644 .gitignore

-- 
2.24.0

