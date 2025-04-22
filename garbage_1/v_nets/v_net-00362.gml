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
  id 362
  arrival_time 6869.484352444982
  lifetime 3001.607229211245
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 20
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 9
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 3
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 24
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 42
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 3
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 25
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 46
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 8
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 6
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 43
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 9
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 33
    rom 13
  ]
  node [
    id 13
    label "13"
    cpu 4
    gpu 27
    rom 40
  ]
  node [
    id 14
    label "14"
    cpu 24
    gpu 23
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
  edge [
    source 13
    target 14
    bw 2
  ]
]
