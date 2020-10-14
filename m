Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317AC28E3E6
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Oct 2020 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgJNQCc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Oct 2020 12:02:32 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:33465 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgJNQCc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:02:32 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 031d4d4f
        for <netfilter-devel@vger.kernel.org>;
        Wed, 14 Oct 2020 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=YY5oHOTtYZRPXAaHxhYnttukzv0=; b=wzyVc1
        Gb9JcYBXUF3GgrTvZ7XkRt/2934MXC53xOO9SHWXZPrSSabFJX7vB5BZ6Fbaopfs
        V5CzySO5cmxc5N28rDD8Ex8+vHn1Y1a6UlxM01+CjvBaV6DgGQypOVYrlPvQX5tL
        b1aB1k2M9lV6PtksSCOtVaXYXflGCgGO3lt7BPeJN8S1PvNdiIc2/jp7/MUDC1zt
        pUTob0Z+N1R5rjfEovLF+0Sdfg7tp+n9WrNWku674LYbpnF0GX7PsqP122ZDHcnk
        oU2oKLQbHE7CLLg6ciuibbN0bquLjicFHxwNXj0qn8Yc+i24OJCoKdnDUj5Bm0vo
        9QoTpzRgsvR4ogqw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e62417d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <netfilter-devel@vger.kernel.org>;
        Wed, 14 Oct 2020 15:28:57 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id r10so5779288ilm.11
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Oct 2020 09:02:29 -0700 (PDT)
X-Gm-Message-State: AOAM530R0g/aX+jeRpCEoaug1WY37ygNPHISV9O+UdYdO7mlIxBLHuSK
        dd2RhTs6C3/3Goy6WqadSCaWJ/IqHm5iCo5JelM=
X-Google-Smtp-Source: ABdhPJz1ck4sR97pFwXWsgejMQA8MyuMU4M9KcmcziSHZE0Kfh4FqQiEZvu7IY1mPwdxPBugZ6IRg1kwcnzuCiLDn2Y=
X-Received: by 2002:a92:c142:: with SMTP id b2mr4381536ilh.207.1602691349066;
 Wed, 14 Oct 2020 09:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201014154408.1053-1-pablo@netfilter.org>
In-Reply-To: <20201014154408.1053-1-pablo@netfilter.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 14 Oct 2020 18:02:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9pjehWejXEMb=KqAG5VLoeMi3GCS4+HdEFhYqJCk0H4wg@mail.gmail.com>
Message-ID: <CAHmME9pjehWejXEMb=KqAG5VLoeMi3GCS4+HdEFhYqJCk0H4wg@mail.gmail.com>
Subject: Re: [PATCH nf-next] netfilter: restore NF_INET_NUMHOOKS
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Seems to work! Thanks for the quick patch.

Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
