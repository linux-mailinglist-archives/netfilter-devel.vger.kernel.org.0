Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B60E98FF
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 10:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfJ3JPZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Oct 2019 05:15:25 -0400
Received: from correo.us.es ([193.147.175.20]:54042 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JPZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:15:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2222B1BFA96
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 10:15:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 136E0B7FFB
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 10:15:21 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 091ACB8007; Wed, 30 Oct 2019 10:15:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 29CD0B7FFE
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 10:15:19 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 30 Oct 2019 10:15:19 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0735742EE396
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 10:15:18 +0100 (CET)
Date:   Wed, 30 Oct 2019 10:15:21 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question
Message-ID: <20191030091521.gosjooprb27xgoc6@salvia>
References: <20191030090707.GB6302@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030090707.GB6302@dimstar.local.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:07:07PM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> When setting verdicts, does sending amended packet contents imply to accept the
> packet? In my app I have assumed not and that seems to work fine, but I'd like
> to be sure for the doco.

If you set the verdict to NF_ACCEPT and the packet that you send back
to the kernel is mangled, then the kernel takes your mangled packet
contents.

Thanks.
