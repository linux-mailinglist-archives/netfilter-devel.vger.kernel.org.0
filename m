Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383544A4113
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Jan 2022 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358886AbiAaLB6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Jan 2022 06:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358672AbiAaLBA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:01:00 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEACC06178A
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jan 2022 02:59:47 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n17so16345962iod.4
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jan 2022 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FANIUiWvB3mdY3zLX2DODg2pUIL5eGT5wlydl6jYk40=;
        b=OjUeAkMVzEddLMMo5PnTCjKyhCs1ageGmC5+cFdXpsSEtg6JbUDTvXCRmwfTUCSofJ
         slj36zZmhn3J4uwPw0DJBjnv3hUS5m+nEauuYDUNcCWjc1f+d0I+yOjKIUc0Pgz+j5Ue
         rRdRGfWkjcSXGfwT+M+UDneKFOQe0c6aLr+5TauC2FupNgb1qyGc5yiIkJ8k0NAmHZhf
         anrjd59/OgrastnWs4ZkrvFaIDjw5pd3eh107tNZ/TuMjnW3micCxNZKM2MDkg13GKwm
         O5Q6tfm8j18o2CLpoCl1kG865M+uxrSOQqgPJI+OJu79ECke4sTf94bEwDsB5fZLVwuG
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FANIUiWvB3mdY3zLX2DODg2pUIL5eGT5wlydl6jYk40=;
        b=ygXj6cBP2KbjUoL3lNwS29Vc7Mg6yaKOmaOdCfdqwZIVOda8g+70/acIKPiQ5cit4g
         ZDRDxQh8uuVPgx6e+7avyQuefEkKsKgOS1g/6DO2euC6OFZemvSD5Yvt7iMx6w+6lash
         Ss7ireDnWeySKYXeOs990v7OyCwZz2RO9cMraKndpehmb2B2QOQaYTqtQkMLqg8cJzxP
         gv+jLu1F+Ijd0njjJA5esijEuGg7cSXhCYzeNeWo48SlNliyg+9HS4UxRv7ebwEl4OkD
         HzxCwYHh1TFuXaGAj0izIHZBLb3iegGhpfSv4dSj+xYRx4N9K5HfMLg3Io4/vthTB4oP
         uXyg==
X-Gm-Message-State: AOAM53087a+wuY7RwZjRlhYJJzI0myMgW0SyKCr00MxH9NcqwaTn2Iwy
        kjfI4us48aWM9SP/2jr2+ll7tQDulsV4ugIEB5g=
X-Google-Smtp-Source: ABdhPJx07OLMUPeEc0ImjaiJBKF2Mcc3ZmsWTIoSvX2FNfz03c1HE0RFqesREnjvPqYHKyL/ALkhu5ugV57XI3T5t/k=
X-Received: by 2002:a6b:441a:: with SMTP id r26mr10856124ioa.211.1643626786286;
 Mon, 31 Jan 2022 02:59:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: daniellakyle60@gmail.com
Sender: drdanielmorris11111@gmail.com
Received: by 2002:a05:6638:1248:0:0:0:0 with HTTP; Mon, 31 Jan 2022 02:59:45
 -0800 (PST)
From:   Mrs daniell akyle <daniellakyle60@gmail.com>
Date:   Mon, 31 Jan 2022 11:59:45 +0100
X-Google-Sender-Auth: xE_x512-NJSetLeK1z_d90RC9Q0
Message-ID: <CAKFcj-P8h0HeDMtZZnog7Sh8cFMKV7095BN2fQnUMpCGPgmhFg@mail.gmail.com>
Subject: Ahoj
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pozdravy
Jmenuji se pan=C3=AD Daniella Kyleov=C3=A1, je mi 58 let
Filip=C3=ADny. V sou=C4=8Dasn=C3=A9 dob=C4=9B jsem hospitalizov=C3=A1n na F=
ilip=C3=ADn=C3=A1ch, kde jsem
podstupuje l=C3=A9=C4=8Dbu akutn=C3=ADho karcinomu j=C3=ADcnu. jsem um=C3=
=ADraj=C3=ADc=C3=AD,
vdova, kter=C3=A1 se rozhodla darovat =C4=8D=C3=A1st sv=C3=A9ho majetku spo=
lehliv=C3=A9 osob=C4=9B
kter=C3=A1 tyto pen=C3=ADze pou=C5=BEije na pomoc chud=C3=BDm a m=C3=A9n=C4=
=9B privilegovan=C3=BDm. Chci
poskytnout dar ve v=C3=BD=C5=A1i 3 700 000 =C2=A3 na sirotky nebo charitati=
vn=C3=AD organizace
ve va=C5=A1=C3=AD oblasti. Zvl=C3=A1dne=C5=A1 to? Pokud jste ochotni tuto n=
ab=C3=ADdku p=C5=99ijmout
a ud=C4=9Blejte p=C5=99esn=C4=9B tak, jak v=C3=A1m =C5=99=C3=ADk=C3=A1m, pa=
k se mi vra=C5=A5te pro dal=C5=A1=C3=AD vysv=C4=9Btlen=C3=AD.
pozdravy
Pan=C3=AD Daniella Kyleov=C3=A1
