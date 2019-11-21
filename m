Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08781052A0
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKUNGk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 08:06:40 -0500
Received: from correo.us.es ([193.147.175.20]:48754 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUNGk (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:06:40 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6A3DDBAE99
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:06:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5CEC3B7FF2
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:06:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 51FD3B8001; Thu, 21 Nov 2019 14:06:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 73150B7FFE;
        Thu, 21 Nov 2019 14:06:33 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 21 Nov 2019 14:06:33 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4CEEB42EF4E2;
        Thu, 21 Nov 2019 14:06:33 +0100 (CET)
Date:   Thu, 21 Nov 2019 14:06:34 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC 2/4] src: add ability to set/get secmarks to/from connection
Message-ID: <20191121130634.nohe3p7coyx3pd7u@salvia>
References: <20191120174357.26112-1-cgzones@googlemail.com>
 <20191120174357.26112-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120174357.26112-2-cgzones@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:43:55PM +0100, Christian G�ttsche wrote:
> Labeling established and related packets requires the secmark to be stored in the connection.
> Add the ability to store and retrieve secmarks like:
> 
>     ...
>     chain input {
>         ...
> 
>         # label new incoming packets
>         ct state new meta secmark set tcp dport map @secmapping_in
> 
>         # add label to connection
>         ct state new ct secmark set meta secmark
> 
>         # set label for est/rel packets from connection
>         ct state established,related meta secmark set ct secmark
> 
>         ...
>     }
>     ...
>     chain output {
>         ...
> 
>         # label new outgoing packets
>         ct state new meta secmark set tcp dport map @secmapping_out
> 
>         # add label to connection
>         ct state new ct secmark set meta secmark
> 
>         # set label for est/rel packets from connection
>         ct state established,related meta secmark set ct secmark
> 
>         ...
>         }
>     ...

I have applied this with minor changes on the evaluation side. Just
follow up with another patch in case you find any issue.

Thanks.
