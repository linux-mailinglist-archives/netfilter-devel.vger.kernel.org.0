Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59A18E5F5
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Mar 2020 03:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCVCVP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 21 Mar 2020 22:21:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37075 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgCVCVP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 21 Mar 2020 22:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584843674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0+7mH9ULrlFiqrxdM9qUEux3gSJesG59qBNYn3dTQA0=;
        b=UHoSu5ZjWl9RbsN4zwcJJJyj17k7VrZAxo9fpxUf77yaCNmLHkDAm2q9itSUymSygEVo/x
        6PJQH6YE+SVxdHerREBDmojTKcC8ZIKyEjmXJQ2g4t9BY7+9WXJMZxeJgn6xOtVW0gSFmh
        zX+NvqZQFuNiRnPfUhYaDlA82YI0luY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96--xrbTJNrMCCVpFGd96zaVg-1; Sat, 21 Mar 2020 22:21:10 -0400
X-MC-Unique: -xrbTJNrMCCVpFGd96zaVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F85800D53;
        Sun, 22 Mar 2020 02:21:09 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.40.208.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7873B9494E;
        Sun, 22 Mar 2020 02:21:08 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Mithil Mhatre <mmhatre@redhat.com>
Subject: [PATCH NOMERGE iptables 0/2] man: xt_set: Describe existing behaviour and new counters update flag
Date:   Sun, 22 Mar 2020 03:20:52 +0100
Message-Id: <20200322022054.3447876-1-sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Patch 1/2 adjusts flag description to the current behaviour flags related
to counters, and patch 2/2 describes the new --update-counters-first flag
as proposed by Kadlecsik J=C3=B3zsef.

Please don't merge before --update-counters-first is actually introduced.

Stefano Brivio (2):
  man: xt_set: Reflect current behaviour of counter update and match
    flags
  man: xt_set: Describe --update-counters-first flag

 extensions/libxt_set.man | 44 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

--=20
2.24.1

