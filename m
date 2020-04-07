Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0351A109F
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2020 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDGPs3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:48:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgDGPs3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586274508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ9p2X0paZu7j0U9ZnL5B0Ng08UrZgz1GAgSIVqPWek=;
        b=hgaZuv3bYrhvxs8XlUf/f7WUdMHy5T4Ge1IG4F6jpFSR+n9vti4AuF+X498TQz432lVgTw
        mccmDbW+/vn/yO0RInFVkrYJ/vJADRfB1xgZgfg6M+6kyY0rsbUpa7CL6MvYc+3UOr5+Y1
        ailNFQWA6pObZo6hKkOQQEhu2A1wZAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-YvLV12nvMQWV1DB48N2qfA-1; Tue, 07 Apr 2020 11:48:26 -0400
X-MC-Unique: YvLV12nvMQWV1DB48N2qfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7704580268E;
        Tue,  7 Apr 2020 15:48:20 +0000 (UTC)
Received: from localhost (unknown [10.36.110.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E87D28980;
        Tue,  7 Apr 2020 15:48:18 +0000 (UTC)
Date:   Tue, 7 Apr 2020 17:48:14 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 2/2] netfilter: nf_tables: reintroduce the
 NFT_SET_CONCAT flag
Message-ID: <20200407174814.04b4cda2@redhat.com>
In-Reply-To: <20200407153653.137377-2-pablo@netfilter.org>
References: <20200407153653.137377-1-pablo@netfilter.org>
        <20200407153653.137377-2-pablo@netfilter.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue,  7 Apr 2020 17:36:53 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> Stefano originally proposed to introduce this flag, users hit EOPNOTSUPP
> in new binaries with old kernels when defining a set with ranges in
> a concatenation.
> 
> Fixes: f3a2181e16f1 ("netfilter: nf_tables: Support for sets with multiple ranged fields")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

