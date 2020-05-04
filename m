Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384B41C39C6
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 May 2020 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEDMpe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 May 2020 08:45:34 -0400
Received: from correo.us.es ([193.147.175.20]:50300 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgEDMpc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 May 2020 08:45:32 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CC73B1B5D12
        for <netfilter-devel@vger.kernel.org>; Mon,  4 May 2020 14:45:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BAA6C52CB1
        for <netfilter-devel@vger.kernel.org>; Mon,  4 May 2020 14:45:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B29CF52B8F; Mon,  4 May 2020 14:45:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9349E11541C;
        Mon,  4 May 2020 14:45:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 May 2020 14:45:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 74C3142EF4E2;
        Mon,  4 May 2020 14:45:27 +0200 (CEST)
Date:   Mon, 4 May 2020 14:45:27 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC] concat with dynamically sized fields like vlan id
Message-ID: <20200504124527.GA25213@salvia>
References: <20200501205915.24682-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20200501205915.24682-1-michael-dev@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2020 at 10:59:15PM +0200, Michael Braun wrote:
> This enables commands like
> 
>  nft set bridge t s4 '{typeof vlan id . ip daddr; elements = { 3567 .
> 1.2.3.4 }; }'
> 
> Which would previously fail with
>   Error: can not use variable sized data types (integer) in concat
>   expressions

Now that typeof is in place, the integer_type can be set to 32-bits
(word size).

I would prefer to not expose the integer type definition to sets:

> +	set s4 {
> +		type integer . ipv4_addr
> +		elements = { 0 . 13.239.0.0 }
> +	}
> +

Users do not need to know that an 8-bit payload field is actually
aligned to 32-bits. Or that osf name is actually and 32-bit id number.

--liOOAslEiF7prFVr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="x.patch"

diff --git a/src/datatype.c b/src/datatype.c
index 723ac649ea42..6a9b0239d37c 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -397,6 +397,7 @@ const struct datatype integer_type = {
 	.type		= TYPE_INTEGER,
 	.name		= "integer",
 	.desc		= "integer",
+	.size		= 4 * BITS_PER_BYTE,
 	.print		= integer_type_print,
 	.json		= integer_type_json,
 	.parse		= integer_type_parse,

--liOOAslEiF7prFVr--
