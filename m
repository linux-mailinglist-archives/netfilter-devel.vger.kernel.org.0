Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43094E58E4
	for <lists+netfilter-devel@lfdr.de>; Sat, 26 Oct 2019 08:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJZG7p (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Oct 2019 02:59:45 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59213 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfJZG7p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 02:59:45 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 6AF163A0535
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Oct 2019 17:59:33 +1100 (AEDT)
Received: (qmail 18028 invoked by uid 501); 26 Oct 2019 06:59:32 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnfnetlink v2 0/2] Minimally resurrect doxygen documentation
Date:   Sat, 26 Oct 2019 17:59:30 +1100
Message-Id: <20191026065932.17985-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191026051937.GA17407@dimstar.local.net>
References: <20191026051937.GA17407@dimstar.local.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10
        a=pUa2rezST_WYV4xYt1oA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The documentation was written in the days before doxygen required groups or even
doxygen.cfg, so create doxygen.cfg.in and introduce one \defgroup per source
file, encompassing pretty-much the whole file.

Also add a tiny \mainpage.

--
v2: main page and function pages make it clear to use libmnl for new apps

Duncan Roe (2):
  Minimally resurrect doxygen documentation
  Make it clear that this library is deprecated

 configure.ac         |   2 +-
 doxygen.cfg.in       | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux_list.h |   9 +++
 src/iftable.c        |  13 ++++
 src/libnfnetlink.c   |  28 +++++++-
 5 files changed, 230 insertions(+), 2 deletions(-)
 create mode 100644 doxygen.cfg.in

-- 
2.14.5

