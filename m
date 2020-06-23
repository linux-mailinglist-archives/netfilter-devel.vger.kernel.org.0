Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8315D20488C
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 06:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgFWENS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 00:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgFWENS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:13:18 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470DC061573
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 21:13:17 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 05:34:58 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Subject: Various memory-safety related fixes
Date:   Tue, 23 Jun 2020 05:34:35 +0200
Message-Id: <20200623033443.18184-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-report: Spam detection software, running on the system "Janet.clients.dxld.at",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Hi, here's a slew of fixes for issues discovered while working
    on adding a parser for pretty printed conntrack entries in snprintf_default.c
    format. Most of these were found while debugging my libtheft property tests
    with ASan. 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

here's a slew of fixes for issues discovered while working on adding a
parser for pretty printed conntrack entries in snprintf_default.c
format.

Most of these were found while debugging my libtheft property tests
with ASan.

--Daniel


