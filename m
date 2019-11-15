Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB4FE0C8
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKOPCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 10:02:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfKOPCm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:02:42 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-IVClPbq4MeepBmUjqiQiEg-1; Fri, 15 Nov 2019 10:02:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDC6DBB0;
        Fri, 15 Nov 2019 15:02:36 +0000 (UTC)
Received: from egarver (ovpn-121-25.rdu2.redhat.com [10.10.121.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A32BC891C;
        Fri, 15 Nov 2019 15:02:35 +0000 (UTC)
Date:   Fri, 15 Nov 2019 10:02:33 -0500
From:   Eric Garver <eric@garver.life>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: libnftnl: NFTA_FLOWTABLE_SIZE missing from kernel uapi headers
Message-ID: <20191115150233.fnlhnlbn2k6qvqwi@egarver>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IVClPbq4MeepBmUjqiQiEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

libnftnl commit cdaea7f1ced0 ("flowtable: allow to specify size") added
the enum value NFTA_FLOWTABLE_SIZE, but this was not first added to the
kernel. As such, libnftnl's header and the kernel are out of sync.

Since then, NFTA_FLOWTABLE_FLAGS has been added to the kernel. This
means NFTA_FLOWTABLE_SIZE in libnftnl and NFTA_FLOWTABLE_FLAGS in the
kernel have the same enum value.

Luckily NFTA_FLOWTABLE_FLAGS was just recently added to -next, so we
should be able to fix this without too much headache.

Thanks.
Eric.

