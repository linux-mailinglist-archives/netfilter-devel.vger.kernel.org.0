Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24B267D2
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfEVQOt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 12:14:49 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42998 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfEVQOt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 12:14:49 -0400
Received: from localhost ([::1]:56084 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hTTt9-0008TG-8Y; Wed, 22 May 2019 18:14:47 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: [nft PATCH v3 0/2] JSON schema for nftables.py
Date:   Wed, 22 May 2019 18:14:51 +0200
Message-Id: <20190522161453.23096-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Round three of JSON validation enhancement.

Changes since v2:
- Make enhancement to nftables module Python3 compliant.
- Complain in nft-test.py if --schema was given without --json.

Changes since v1:
- Fix patch 2 commit message, thanks to Jones Desougi who reported the
  inconsistency.

Changes since RFC:
- Import builtin traceback module unconditionally.

Phil Sutter (2):
  py: Implement JSON validation in nftables module
  tests/py: Support JSON validation

 py/Makefile.am       |  2 +-
 py/nftables.py       | 29 +++++++++++++++++++++++++++++
 py/schema.json       | 17 +++++++++++++++++
 py/setup.py          |  1 +
 tests/py/nft-test.py | 25 ++++++++++++++++++++++++-
 5 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 py/schema.json

-- 
2.21.0

