Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AE2177B
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 May 2019 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfEQLJc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 May 2019 07:09:32 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:55684 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfEQLJb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 May 2019 07:09:31 -0400
Received: from localhost ([::1]:40542 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hRajy-00083m-4E; Fri, 17 May 2019 13:09:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/2] JSON schema for nftables.py
Date:   Fri, 17 May 2019 13:09:29 +0200
Message-Id: <20190517110931.14068-1-phil@nwl.cc>
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

