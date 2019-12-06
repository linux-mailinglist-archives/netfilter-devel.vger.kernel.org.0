Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1146E114E0A
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFJQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 04:16:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbfLFJQD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575623762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkohueDdF8wBhA3RIz6/uE0KTPMgkdP4raHwLtLKcwU=;
        b=SkrhZk1SvkzWHacgeMFfxnIpiu5UP5OfL7286oBz5nFJ7P54KwgJqid4zGCUci5ryvA3yO
        o0xgQ0r0IlQLPt+Xyn353jfGiHHxvE3Di7hOt4mb3REkh7SqFVROlMish3mP8O30+lhXnl
        yCSphqGxbHn2MDb6mRqh+ty8pDeQMVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-pDUvMiAlMQ-gsfWwiOY6bA-1; Fri, 06 Dec 2019 04:15:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ED301883522;
        Fri,  6 Dec 2019 09:15:58 +0000 (UTC)
Received: from elisabeth (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBF46BF60;
        Fri,  6 Dec 2019 09:15:54 +0000 (UTC)
Date:   Fri, 6 Dec 2019 10:15:49 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     <netfilter-devel@vger.kernel.org>, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nf] selftests: netfilter: use randomized netns names
Message-ID: <20191206101549.4b05f74a@elisabeth>
In-Reply-To: <20191202173540.12230-1-fw@strlen.de>
References: <20191202173540.12230-1-fw@strlen.de>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pDUvMiAlMQ-gsfWwiOY6bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon,  2 Dec 2019 18:35:40 +0100
Florian Westphal <fw@strlen.de> wrote:

> Using ns0, ns1, etc. isn't a good idea, they might exist already.
> Use a random suffix.

Incidentally, this was the same approach we originally used in
net/pmtu.sh, and after a while it proved to be quite inconvenient, leading
to commit a92a0a7b8e7c ("selftests: pmtu: Simplify cleanup and namespace
names").

I'm not sure this is necessarily the case here, though, as nft_nat.sh
doesn't implement pause-on-fail.

-- 
Stefano

