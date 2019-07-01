Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C038C2FE4A
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 May 2019 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE3OoS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 10:44:18 -0400
Received: from mail.us.es ([193.147.175.20]:43368 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfE3OoR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 10:44:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2103E1BCFC0
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 16:44:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 10B32DA709
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 16:44:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0653EDA706; Thu, 30 May 2019 16:44:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1401DDA70A;
        Thu, 30 May 2019 16:44:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 May 2019 16:44:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E6F714265A32;
        Thu, 30 May 2019 16:44:12 +0200 (CEST)
Date:   Thu, 30 May 2019 16:44:12 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Robin Geuze <robing@transip.nl>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] Apply userspace filter on resync with internal cache
 disabled
Message-ID: <20190530144412.fsyamd2wbzdraq3s@salvia>
References: <AM0PR02MB549235F7DFDD08E5C47E2B0AAA1E0@AM0PR02MB5492.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR02MB549235F7DFDD08E5C47E2B0AAA1E0@AM0PR02MB5492.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 28, 2019 at 09:24:18AM +0000, Robin Geuze wrote:
> Always apply the userspace filter when doing a direct sync from the
> kernel when internal cache is disabled, since a dump does not apply
> a kernelspace filter.

Applied, thanks.
