Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD228A99C
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Oct 2020 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgJKTXq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Oct 2020 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJKTXq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Oct 2020 15:23:46 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30BC0613CE
        for <netfilter-devel@vger.kernel.org>; Sun, 11 Oct 2020 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UlTd4oelOXTVBlr169gbFvAkZVciQ9o2maL0hBAwiq4=; b=NaI5AV0V+VzR9qDHLo/jEJsoYP
        Sg87WXmXmQx1X0GkxsdP0epIXSBzCxAdxcYLSSNJnh6F5BzGuAsNiu9snP4BVKpsFIIQuhsYZSh4F
        41tadLmjVWUFlf/7B6Uw6H0wNastZy3FBw+PY6sDI/hOD2Z1WBSBl+Qtt7N1naYPP04OiFMhBiC43
        0clK95wggcSD8OmR2+hB3IGsS1o/2UW7z7TS0TsZ7kvWgYbokToelkjFYEZIRb3pPGZu80AVW0ny8
        jknS+ikc0ARpn5H/if96oGi3Oo+LSRzmVGGHttv8fdPdofTUGgk0gX7QNvWAvHjeDD+40mO3h8t4z
        IDrCfKQw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kRgwX-00016N-G7; Sun, 11 Oct 2020 20:23:41 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 0/3] tests: py: fixes for failing JSON tests
Date:   Sun, 11 Oct 2020 20:23:21 +0100
Message-Id: <20201011192324.209237-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes for a few Python tests with missing or incorrect JSON output.

Jeremy Sowden (3):
  tests: py: add missing JSON output for ct test.
  tests: py: correct order of set elements in test JSON output.
  tests: py: add missing test JSON output for TCP flag tests.

 tests/py/any/ct.t.json          | 15 ++++++
 tests/py/any/ct.t.json.output   | 20 +++----
 tests/py/inet/tcp.t.json        | 93 +++++++++++++++++++++++++++++++++
 tests/py/inet/tcp.t.json.output | 93 +++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+), 10 deletions(-)

-- 
2.28.0

