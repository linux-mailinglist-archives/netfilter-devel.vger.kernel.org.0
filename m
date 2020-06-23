Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41A20528D
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgFWMeq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgFWMep (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:34:45 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F00C061755
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2020 05:34:44 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 14:34:41 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Subject: Various memory-safety related fixes
Date:   Tue, 23 Jun 2020 14:33:55 +0200
Message-Id: <20200623123403.31676-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

PS: Resending because of problems with unencoded 8bit garbage in mail
header.


