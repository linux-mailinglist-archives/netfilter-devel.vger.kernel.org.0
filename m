Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A030A14199A
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 21:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgARUZF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 15:25:05 -0500
Received: from correo.us.es ([193.147.175.20]:51012 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgARUZF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:25:05 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E945A3066A2
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:25:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DA9B0DA709
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:25:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D0556DA702; Sat, 18 Jan 2020 21:25:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6265DA709;
        Sat, 18 Jan 2020 21:25:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 18 Jan 2020 21:25:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C092941E4800;
        Sat, 18 Jan 2020 21:25:01 +0100 (CET)
Date:   Sat, 18 Jan 2020 21:25:01 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnftnl v2 0/6] bitwise shift support
Message-ID: <20200118202501.pwmfzlqypdco4dts@salvia>
References: <20200117205808.172194-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117205808.172194-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:58:02PM +0000, Jeremy Sowden wrote:
> The kernel supports bitwise shift operations.  This patch-set adds the
> support to libnftnl.  There are couple of preliminary housekeeping
> patches.

Series applied, thanks.
