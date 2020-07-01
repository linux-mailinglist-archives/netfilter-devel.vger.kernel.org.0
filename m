Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED04210A1E
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2020 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgGALJz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jul 2020 07:09:55 -0400
Received: from correo.us.es ([193.147.175.20]:40636 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbgGALJz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:09:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 68064DA72F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 13:09:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 58C94DA844
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 13:09:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 58346DA840; Wed,  1 Jul 2020 13:09:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 375FCDA796;
        Wed,  1 Jul 2020 13:09:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 01 Jul 2020 13:09:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 151624265A2F;
        Wed,  1 Jul 2020 13:09:52 +0200 (CEST)
Date:   Wed, 1 Jul 2020 13:09:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnf_ct PATCH v2 1/9] Handle negative snprintf return values
 properly
Message-ID: <20200701110951.GA1346@salvia>
References: <20200624133005.22046-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624133005.22046-1-dxld@darkboxed.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:29:57PM +0200, Daniel Gr�ber wrote:
> Currently the BUFFER_SIZE macro doesn't take negative 'ret' values into
> account. A negative return should just be passed through to the caller,
> snprintf will already have set 'errno' properly.

Series applied, thanks.

> diff --git a/include/internal/internal.h b/include/internal/internal.h
> index bb44e12..b1fc670 100644
> --- a/include/internal/internal.h
> +++ b/include/internal/internal.h
> @@ -41,6 +41,8 @@
>  #endif
>  
>  #define BUFFER_SIZE(ret, size, len, offset)		\
> +	if (ret < 0)					\
> +		return -1;				\

Side note: I don't like this hidden branch under a macro. But
snprintf() == -1 is unlikely to happen and I don't have a better idea
to deal with this case ATM.
