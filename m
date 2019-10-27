Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7FE61B2
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Oct 2019 09:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJ0Ite (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Oct 2019 04:49:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34309 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfJ0Ite (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Oct 2019 04:49:34 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id CDBAB3A07DA
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Oct 2019 19:49:07 +1100 (AEDT)
Received: (qmail 24334 invoked by uid 501); 27 Oct 2019 08:49:07 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnfnetlink v3 0/2] Minimally resurrect doxygen documentation
Date:   Sun, 27 Oct 2019 19:49:05 +1100
Message-Id: <20191027084907.24291-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191026051937.GA17407@dimstar.local.net>
References: <20191026051937.GA17407@dimstar.local.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10
        a=gKb2Q7pwNYcF63mW8iUA:9
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
v3: add Signed-off-by

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

