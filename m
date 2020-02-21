Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E6166C9B
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Feb 2020 03:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgBUCFS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Feb 2020 21:05:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728992AbgBUCFR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582250716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zsjOErM+30cAPCyytP8LchEmwuTf4jjmtH5KjSyC9Y=;
        b=P9iDrUZo6+GQ4X+/h3F6dTIBOUe85iup/McaLs8ditNzp7MBdy0enKGlhlS2hHvtbr/eES
        t5B8lGkNC3X6Qus6pdYk+KEzn9kz+bPEvMS9Yld+7Bi01JyNOcUg57jK9NhM5Sq98uWO0C
        H1NYq7DmXG/V6K95bCCxD33+HahbrsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-3cmRU2L_OO6CUci_kFRAgA-1; Thu, 20 Feb 2020 21:05:14 -0500
X-MC-Unique: 3cmRU2L_OO6CUci_kFRAgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464228010E7;
        Fri, 21 Feb 2020 02:05:13 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF1960C87;
        Fri, 21 Feb 2020 02:05:11 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nf 0/2] nft_set_pipapo: Fix crash due to dangling entries in mapping table
Date:   Fri, 21 Feb 2020 03:04:20 +0100
Message-Id: <cover.1582250437.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Patch 1/2 fixes the issue recently reported by Phil on a sequence of
add/flush/add operations, and patch 2/2 introduces a test case
covering that.

Stefano Brivio (2):
  nft_set_pipapo: Actually fetch key data in nft_pipapo_remove()
  selftests: nft_concat_range: Add test for reported add/flush/add issue

 net/netfilter/nft_set_pipapo.c                |  6 ++-
 .../selftests/netfilter/nft_concat_range.sh   | 43 +++++++++++++++++--
 2 files changed, 43 insertions(+), 6 deletions(-)

--=20
2.25.0

