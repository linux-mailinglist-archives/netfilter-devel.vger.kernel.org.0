Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC53BBA29
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGEJa3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 05:30:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34304 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhGEJa2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:30:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73FB622692;
        Mon,  5 Jul 2021 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625477271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JiQRbESh5Ufmk0jSuX1LVUz6s7KZCA0+MaN+HENWn4=;
        b=SVwbn0roV3h/ImxWxgU741snhaw0JpNwCNOn+RCavn27MB9a6jE6GfB8vWFMEcfmnDnRjk
        Ozo5LwIkXOoX8B/eO2Mlrl+m/FGb0KiR5HN9amvl1IuFjayWWpwdThq0Q+UBM2WmW2F7d1
        cr4hvDFMWauLD9BauW3I+jafgfsZiS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625477271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JiQRbESh5Ufmk0jSuX1LVUz6s7KZCA0+MaN+HENWn4=;
        b=aQcvv0/TIHwAAM0mG8irG38r2ht1WQYm0Qlt9blcq9s5yrMNfgaVW7ECe9F2HJXJeOyBiv
        E3/t5XEnhJ/ROTCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 674FF139A1;
        Mon,  5 Jul 2021 09:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AEyuGJfQ4mA/TAAAGKfGzw
        (envelope-from <aabdallah@suse.de>); Mon, 05 Jul 2021 09:27:51 +0000
MIME-Version: 1.0
Date:   Mon, 05 Jul 2021 11:27:51 +0200
From:   aabdallah <aabdallah@suse.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: improve RST handling when tuple
 is re-used
In-Reply-To: <20210520105311.20745-1-fw@strlen.de>
References: <20210520105311.20745-1-fw@strlen.de>
User-Agent: Roundcube Webmail
Message-ID: <7f02834fae6dde2d351650177375d004@suse.de>
X-Sender: aabdallah@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I see that this commit [1] is still under review, is there is any change 
that it will be reviewed and merged soon? Thanks.

[1] 
https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=244902
