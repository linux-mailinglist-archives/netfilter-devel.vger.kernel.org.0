Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2321EF2
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 May 2019 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEQUR7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 May 2019 16:17:59 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56704 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEQUR7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 May 2019 16:17:59 -0400
Received: from localhost ([::1]:41562 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hRjIj-0004r0-2Q; Fri, 17 May 2019 22:17:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: [nft PATCH v2 0/2] JSON schema for nftables.py
Date:   Fri, 17 May 2019 22:17:56 +0200
Message-Id: <20190517201758.1576-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is basically identical to the RFC sent earlier. The only change is
in second patch: As suggested by Eric, 'traceback' module is standard so
there's no need to import it conditionally.

The schema is still in its minimalistic form, I decided to extend it in
follow-up patches.

Changes since v1:
- Fix patch 2 commit message, thanks to Jones Desougi who reported the
  inconsistency.

Phil Sutter (2):
  py: Implement JSON validation in nftables module
  tests/py: Support JSON validation

 py/Makefile.am       |  2 +-
 py/nftables.py       | 30 ++++++++++++++++++++++++++++++
 py/schema.json       | 17 +++++++++++++++++
 py/setup.py          |  1 +
 tests/py/nft-test.py | 21 ++++++++++++++++++++-
 5 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 py/schema.json

-- 
2.21.0

