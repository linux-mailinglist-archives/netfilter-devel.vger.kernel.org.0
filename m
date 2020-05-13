Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9271D1CB3
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2020 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgEMR52 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 13 May 2020 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732611AbgEMR51 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 13 May 2020 13:57:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD8C061A0C
        for <netfilter-devel@vger.kernel.org>; Wed, 13 May 2020 10:57:27 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id j8so18985301iog.13
        for <netfilter-devel@vger.kernel.org>; Wed, 13 May 2020 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLNoimdegMJVSp5u3b48H5Ye37PeOPouP0xmLALcNm8=;
        b=ImDEnMFtJgTKOIh5RvM2NQnMLctBhi+Q5e/b+1oRt4THDMdSRwXZXoXepxzi43cLR9
         3cKJugKhMJ+HpodyWLq70i5hK71xk3gG69sePaESkijM1iM49ZsK9K6SdHWj2g39Uq6X
         Bcm0WAE/HaCzSY3Leim9o6yiurAKFLjFN85ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLNoimdegMJVSp5u3b48H5Ye37PeOPouP0xmLALcNm8=;
        b=KNv9I9jZhySX+2KyyGgYdV2UUkgenRZIciuON2PjzNgxLtqOUbUWsbECjCowvqRv7/
         w7gsapZQAxEKzG05xdeyepqQYihNxT3XjQm5pgJU9xnkr7WpGgmkMHWdFDv2lIkPo0GQ
         4vC1mV78+VZv8emgwN/4tpRv1tqHuiGydvjjS/gh5yMgx/CM9VDp6rydvuHqkJjVPnOV
         IHKSWpFiohmfaqCcWt00JJ8LI574IsE4joM78SRbXh/u1E4Pbz+io0AHCwYYmSJvW1mL
         4+kfJps8r9mILVzXq3LkKY9VgnhQUZeEmjYPrU2YsmLcrfw0DkhngCmv8H/zRIQuAOQd
         v19w==
X-Gm-Message-State: AOAM531eRrUwEjGK7Y4HUPoxt3N0zDcm/UzrualYAkvOgJHxhqXh0Sdg
        CoVL1QLsn4rU0y4HUSRUdZ06Aqe33VA=
X-Google-Smtp-Source: ABdhPJzSl9tE2JDeCStp0yqpCaID7+E4glHEVd+1/f2MCReJjrkRU8cmKFjSNCaeZRX3tbEz04J0ng==
X-Received: by 2002:a5d:8045:: with SMTP id b5mr424066ior.16.1589392646581;
        Wed, 13 May 2020 10:57:26 -0700 (PDT)
Received: from jacobraz2.hsd1.co.comcast.net ([2601:281:8101:2040::8327])
        by smtp.gmail.com with ESMTPSA id y18sm86240ilq.52.2020.05.13.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 10:57:25 -0700 (PDT)
From:   Jacob Rasmussen <jacobraz@chromium.org>
X-Google-Original-From: Jacob Rasmussen <jacobraz@google.com>
To:     mkubecek@suse.cz
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        Jacob Rasmussen <jacobraz@chromium.org>
Subject: Re: userspace conntrack helper and confirming the master conntrack
Date:   Wed, 13 May 2020 11:54:08 -0600
Message-Id: <20200513175408.195863-1-jacobraz@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20190911081710.GD24779@unicorn.suse.cz>
References: <20190911081710.GD24779@unicorn.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jacob Rasmussen <jacobraz@chromium.org>

Hello everyone,

I'm encountering a bug on Chrome OS that I believe to be caused by commit 827318feb69cb07ed58bb9b9dd6c2eaa81a116ad and I was wondering if there was any update on a fix/revert landing for this. 
If a fix has already landed would anyone mind pointing me to the specific commit because I haven't been able to find it on my own.

Thanks,
Jacob
