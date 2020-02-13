Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5615BE46
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Feb 2020 13:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBMMJ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Feb 2020 07:09:56 -0500
Received: from correo.us.es ([193.147.175.20]:38894 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgBMMJz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:09:55 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B4EC8102CB4
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2020 13:09:55 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A6E13DA715
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2020 13:09:55 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9BAA5DA70E; Thu, 13 Feb 2020 13:09:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C73CADA70E;
        Thu, 13 Feb 2020 13:09:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Feb 2020 13:09:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9DDC242EE38F;
        Thu, 13 Feb 2020 13:09:53 +0100 (CET)
Date:   Thu, 13 Feb 2020 13:09:51 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Serguei Bezverkhi <sbezverk@gmail.com>
Subject: Re: [PATCH nft] src: maps: update data expression dtype based on set
Message-ID: <20200213120951.rmrastno3kkalw6g@salvia>
References: <20200213120617.145154-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213120617.145154-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:06:17PM +0100, Florian Westphal wrote:
> What we want:
> -               update @sticky-set-svc-M53CN2XYVUHRQ7UB { ip saddr : 0x00000002 }
> what we got:
> +               update @sticky-set-svc-M53CN2XYVUHRQ7UB { ip saddr : 0x2000000 [invalid type] }

LGTM, thanks.
