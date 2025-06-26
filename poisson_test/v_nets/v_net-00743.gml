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
  id 743
  arrival_time 15543.088434014177
  lifetime 2720.458942407558
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 4
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 27
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 36
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 42
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 47
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 0
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 14
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 22
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 1
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 11
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
]
