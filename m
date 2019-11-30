Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8955810DD77
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Nov 2019 12:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfK3La7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Nov 2019 06:30:59 -0500
Received: from kadath.azazel.net ([81.187.231.250]:40036 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfK3La7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Nov 2019 06:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Lcm/MMIcgmWBnRt/n60/Zm3srzfoAaTkFKN5x1/8Crg=; b=E8Tk837yx7HleZ6w5fJSh9bF6d
        QZNgKY6mhl7qvuK+1ZJDfy0EmnMVAiEfLSzogNx2NC7QgTe8/o7qjsK0zZmCp/1Eg5rOGYpTb/ShK
        cA+eUocQHWxjcadqFyb89h4Vuzg/t9ucR513sySDt29sijUIiLWVVT/RpsMk50sKn9aJVo4/z5GmQ
        GFXn6PIevuaFPLboNSd+41GMUuWz5yDAXAIlu4IR+UDo7UU3aRnoHsYJAuEpmJmjVCQAY8loMtDdQ
        NM+m9GZGvmJTPPY/pvtzXlL0/EH9EeWqExNHRVS9RYxOyhoJSe+9X7KZTBWq0F4v7ZkK2fKbeH/IG
        vp3+8a7g==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1ib0xl-0002b0-Mw; Sat, 30 Nov 2019 11:30:57 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 0/1] doc: fix inconsistency in set statement documentation.
Date:   Sat, 30 Nov 2019 11:30:56 +0000
Message-Id: <20191130113057.293776-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The description of the set statement asserts that the set must have been
created with the "dynamic" flag, but the following example doesn't
agree.

The simplest way to resolve the inconsistency would be to add the
missing flag to the example, but the description is not correct and the
example doesn't require the flag, so I've attempted to improve the
description.

Change log:

  * In v1, I was under the impression that the "dynamic" flag was never
    required and just dropped all mention of it from the description.
    However, there are circumstances under which it is required, so in
    v2 I expand the description to explain them.

Jeremy Sowden (1):
  doc: fix inconsisntency in set statement documentation.

 doc/statements.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.24.0

