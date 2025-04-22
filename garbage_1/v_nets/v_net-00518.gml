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
  id 518
  arrival_time 9865.526369853866
  lifetime 419.14059005728404
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 50
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 46
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 17
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 41
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 39
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 33
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 1
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 11
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 5
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 8
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 9
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 22
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
]
