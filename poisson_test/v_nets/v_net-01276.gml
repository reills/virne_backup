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
  id 1276
  arrival_time 26730.643926721998
  lifetime 190.78701564947116
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 45
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 2
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 18
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 27
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 9
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 31
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 38
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 0
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 34
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 28
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 17
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 15
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
