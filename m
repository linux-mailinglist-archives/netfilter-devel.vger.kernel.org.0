Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757E39AE6E
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Jun 2021 00:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCW75 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Jun 2021 18:59:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45822 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhFCW75 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:59:57 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id ACBCC641FD
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Jun 2021 00:57:02 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables,v2 0/5] iptables-translation enhancements
Date:   Fri,  4 Jun 2021 00:58:01 +0200
Message-Id: <20210603225806.13625-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is v2 of a previously posted individual patches.

1) Extend libxtables to allow to add a set dependency definition
   for translations. Changes since v1: Fix broken translation
   of single commands with no matches / targets.

2) Update xlate-test.py to deal with multiline translation
   (new in this v2 batch).

3) Add libxt_connlimit xlate support and tests (Changes since v1:
   added tests).

4) Use compact flags match representation in libxt_tcp (new)

5) Use negation to simplify libxt_conntrack translation (new)

Pablo Neira Ayuso (5):
  libxtables: extend xlate infrastructure
  tests: xlate-test: support multiline expectation
  extensions: libxt_connlimit: add translation
  extensions: libxt_tcp: rework translation to use flags match representation
  extensions: libxt_conntrack: simplify translation using negation

 configure.ac                      |  4 +-
 extensions/libxt_TCPMSS.txlate    |  4 +-
 extensions/libxt_connlimit.c      | 49 ++++++++++++++++++
 extensions/libxt_connlimit.txlate | 15 ++++++
 extensions/libxt_conntrack.c      | 46 +++++------------
 extensions/libxt_conntrack.txlate |  8 +--
 extensions/libxt_tcp.c            | 10 ++--
 extensions/libxt_tcp.txlate       |  6 +--
 include/xtables.h                 |  6 +++
 iptables/xtables-translate.c      | 29 ++++++++---
 libxtables/xtables.c              | 82 ++++++++++++++++++++++++-------
 xlate-test.py                     | 14 +++++-
 12 files changed, 196 insertions(+), 77 deletions(-)
 create mode 100644 extensions/libxt_connlimit.txlate

-- 
2.20.1

