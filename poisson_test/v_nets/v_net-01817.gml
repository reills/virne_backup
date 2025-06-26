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
  id 1817
  arrival_time 40286.06380035615
  lifetime 637.7505973058718
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 38
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 42
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 24
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 14
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 19
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 23
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 14
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 33
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 34
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 11
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 31
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 14
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 21
    rom 4
  ]
  node [
    id 13
    label "13"
    cpu 21
    gpu 44
    rom 3
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 33
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
  edge [
    source 12
    target 13
    bw 22
  ]
  edge [
    source 13
    target 14
    bw 9
  ]
]
