Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3C5ECAA
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGCTQg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 15:16:36 -0400
Received: from mail.us.es ([193.147.175.20]:44704 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGCTQg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:16:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 72806C1A00
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 21:16:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6524FDA704
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 21:16:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5AEBEDA732; Wed,  3 Jul 2019 21:16:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 74B96DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 21:16:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 21:16:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 487674265A2F
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 21:16:32 +0200 (CEST)
Date:   Wed, 3 Jul 2019 21:16:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Rebasing nf-next
Message-ID: <20190703191631.mtc2liq5sqxbbwzk@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sorry for the inconvenience.

This is a bit what happens when things are pushed to be done too fast.

It's my fault after all.
