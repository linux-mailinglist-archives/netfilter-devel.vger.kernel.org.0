Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42724E6A1
	for <lists+netfilter-devel@lfdr.de>; Sat, 22 Aug 2020 11:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHVJSD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 22 Aug 2020 05:18:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgHVJSD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598087882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzwgqavxyRz5zKTAkqsjN0bushdWDVuxZeuWskXlYQc=;
        b=KEohuTHKNqVR7X1ns243WGRF+dn2lSplU4/JWDZvUNWIOjjxJTwUsWS7bA3cTP8quOSMuu
        DIKGGMOQ6qf9N9jW+aj7uFfq+mFEaJNsSEbaT95DNP7sYEbq+3t0XPbkecFIed4Qq6pLrK
        OX9U/8lK5Wg2zASv2qr+5oyXrWpAd/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-G8Hu9TtTNfSrQi_G3Jtjvg-1; Sat, 22 Aug 2020 05:18:00 -0400
X-MC-Unique: G8Hu9TtTNfSrQi_G3Jtjvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1395A10051C1;
        Sat, 22 Aug 2020 09:17:59 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A71756E1;
        Sat, 22 Aug 2020 09:17:57 +0000 (UTC)
Date:   Sat, 22 Aug 2020 11:17:52 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Balazs Scheidler <bazsi77@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 2/4] doc: added documentation on "socket
 wildcard"
Message-ID: <20200822111752.5da28997@elisabeth>
In-Reply-To: <20200822062203.3617-3-bazsi77@gmail.com>
References: <20200822062203.3617-1-bazsi77@gmail.com>
        <20200822062203.3617-3-bazsi77@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, 22 Aug 2020 08:22:01 +0200
Balazs Scheidler <bazsi77@gmail.com> wrote:

> @@ -209,15 +209,20 @@ or non-zero bound listening socket (possibly with a non-local address).
>  Value of the IP_TRANSPARENT socket option in the found socket. It can be 0 or 1.|
>  boolean (1 bit)
>  |mark| Value of the socket mark (SOL_SOCKET, SO_MARK). | mark
> +|wildcard|
> +Indicates weather the socket is wildcard-bound (e.g. 0.0.0.0 or ::0). |

s/weather/whether/.

> +boolean (1 bit)
>  |==================
>  
>  .Using socket expression
>  ------------------------
> -# Mark packets that correspond to a transparent socket
> +# Mark packets that correspond to a transparent socket. "socket wildcard 0"
> +# means that zero bound listener sockets are NOT matched (which is usually

"zero-bound" would be a bit clearer (and consistent with the rest).

-- 
Stefano

