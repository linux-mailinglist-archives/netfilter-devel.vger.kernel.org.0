Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5148D2963C9
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Oct 2020 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369204AbgJVRaU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Oct 2020 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368006AbgJVRaT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:30:19 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7025C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Oct 2020 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Cfn9zEVRHu2+pgXhM3HGsmgB7etLYB45W+3Q5bIkwwU=; b=rxjCt424Ou0qItLiobdEIT9ZQB
        B3hn5qXvcKiJZ8ZWZ8J1vkHNIJ8sld0+aW5CpeCz1/4pBcMYVF6l0XEGETQnFvRQs6+w9VZ0k0Voo
        +dpR60YdJASv+NyLPS0Ch6wP+roWbSwgb1dL1kmZ7syBTB6EjtuSlDYfEP0xOhmRtsZrGhkBsMCOU
        FZWqKAFlxBzTW8CXmhciG6UQ8EfgkQHk4w+BhD2yRV8idHIuvkjNUew/KdcmGY7yWdqJ+E8yMm/i+
        58DSuz5i3wTZW1biHo1m17+Hj0EoxmSxgL0phtAoELgzgMNUDWbF/E7XhsZ2VQynJDJrTXHC+X4/x
        LIxm/OFw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kVePl-0003s0-5L; Thu, 22 Oct 2020 18:30:13 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons 0/3] pknlusr improvements
Date:   Thu, 22 Oct 2020 18:30:02 +0100
Message-Id: <20201022173006.635720-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since pknlusr is now installed, here are a few improvements.

Jeremy Sowden (3):
  pknock: pknlusr: fix formatting.
  pknock: pknlusr: fix hard-coded netlink multicast group ID.
  pknock: pknlusr: add man-page.

 extensions/pknock/Makefile.am |  2 ++
 extensions/pknock/pknlusr.8   | 23 +++++++++++++++++++++++
 extensions/pknock/pknlusr.c   | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 extensions/pknock/pknlusr.8

-- 
2.28.0

