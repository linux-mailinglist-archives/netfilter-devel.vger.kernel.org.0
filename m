Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4761A6CD4
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2020 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbgDMTsV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Apr 2020 15:48:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387774AbgDMTsR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586807296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VrC4cYZRpZYEcB77iMsX43+oZMGV1Dtllu58aFr+Ukk=;
        b=F2m3OOmO72mHA4IES9rVvvVLIzFdhXD1IQ2BtSwjRyaV22FXbigGvoJy52E6a88TYbOE8F
        NH75yWchTrLI35//KcA7PTUi8YQv5ASoA1s7w5X0WnctyyAyfwWpncrjCCDcS2Ewk2QAd+
        c5BV3rPgvuB0x/3eqWeMwTrDY1pGxd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-ll3ejIX4N96AlDMM9BT08Q-1; Mon, 13 Apr 2020 15:48:14 -0400
X-MC-Unique: ll3ejIX4N96AlDMM9BT08Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFED913FA;
        Mon, 13 Apr 2020 19:48:13 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF33E96FB1;
        Mon, 13 Apr 2020 19:48:12 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] Prevent kernel from adding concatenated ranges if they're not supported
Date:   Mon, 13 Apr 2020 21:48:01 +0200
Message-Id: <cover.1586806931.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series fixes the nft crash recently reported by Pablo with older
(< 5.6) kernels: use the NFT_SET_CONCAT flag whenever we send a set
including concatenated ranges, so that kernels not supporting them
will not add them altogether, and we won't crash while trying to list
the malformed sets that are added as a result.

Stefano Brivio (2):
  include: Resync nf_tables.h cache copy
  src: Set NFT_SET_CONCAT flag for sets with concatenated ranges

 include/linux/netfilter/nf_tables.h | 2 ++
 src/evaluate.c                      | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

--=20
2.25.1

