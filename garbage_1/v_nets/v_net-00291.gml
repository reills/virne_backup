graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 291
  arrival_time 5662.796014461661
  lifetime 3781.895455999835
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 3
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 49
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 31
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 40
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 41
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 13
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 18
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 33
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 26
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 43
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 7
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 4
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 3
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 34
    gpu 8
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
]
