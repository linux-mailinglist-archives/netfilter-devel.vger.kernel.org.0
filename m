Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7752607
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfFYIGE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 04:06:04 -0400
Received: from mail.us.es ([193.147.175.20]:39810 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbfFYIGD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:06:03 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D1F84C3285
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 10:06:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BDA584CA14
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 10:06:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BCF831021A4; Tue, 25 Jun 2019 10:06:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E08684CA14;
        Tue, 25 Jun 2019 10:05:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 10:05:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BAB604265A31;
        Tue, 25 Jun 2019 10:05:59 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:05:59 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 3/3] build: avoid unnecessary call to xargs
Message-ID: <20190625080559.aum2hhdglqi36d7o@salvia>
References: <20190625065835.31188-1-jengelh@inai.de>
 <20190625065835.31188-3-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625065835.31188-3-jengelh@inai.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Also applied, thanks.
